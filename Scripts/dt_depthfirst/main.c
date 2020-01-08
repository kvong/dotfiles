#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>
#include <errno.h>

/*
	Author: Khanh Vong
	Class: Operating System
	Assignment: Project1
	Date: 9-01-2019
	Description: Recursive depth-first traversal through directories
					(with option on what to display).
*/

// Global
int max_depth_global = 0;
int max_name_global = 0;
int stat_pos = 0;

// Function prototypes
void help();
int isdirectory(char *);
int setMaxDepth(char *, int, int *);
int depthfirst(char *, int , int *, int);
int main(int argc, char *argv[]){
	// flag table {h, I, L, d, g, i, p, s, t, u}
	int *flags = malloc(sizeof(int) * 10); 
	int indent = 4;
	int option;
	// GETOPT to manimpulate *flags
	while((option = getopt(argc, argv, ":hI:Ldgipstul")) != -1){
		switch(option){
			case 'h':
				flags[0] = 1;
				help();
				return 0;
				break;
			case 'I':
				indent = atoi(optarg);
				flags[1] = 1;
				break;
			case 'L':
				flags[2] = 1;
				break;
			case 'd':
				flags[3] = 1;
				break;
			case 'g':
				flags[4] = 1;
				break;
			case 'i':
				flags[5] = 1;
				break;
			case 'p':
				flags[6] = 1;
				break;
			case 's':
				flags[7] = 1;
				break;
			case 't':
				flags[8] = 1;
				break;
			case 'u':
				flags[9] = 1;
				break;
			case 'l':
				flags[8] = 1;
				flags[6] = 1;
				flags[5] = 1;
				flags[9] = 1;
				flags[4] = 1;
				flags[7] = 1;
				break;
			case '?':
				printf("Unknown option entered.\n");
				return 0;
				break;
		}
	}

	// Checking input argument, if any
	char root[80];
	if (argv[optind] != NULL){
		if(isdirectory(argv[optind]) != 0){	
			strcpy(root, "");
			strcat(root, argv[optind]);
		}
		else{
			perror("Error: Invalid argument");
			printf("'%s' is not a directory\n", argv[optind]);
			return 1;
		}
	}
	else{
		strcpy(root, ".");
	}
	
	// Take initial run through directories, useful when outputting
	setMaxDepth(root, 0, flags);
	stat_pos = (max_depth_global * indent) + max_name_global;	

	// Run depth first traversal with given arguments
	depthfirst(root, 0, flags, indent);

	// Perror at end of program
	perror("Result of program");
	return 0;

}

// Usage function
void help(){
	printf("Usage: dt [-h] [-I n] [-L -d -g -i -p -s -t -u | -l] [dirname]\n");
}

// Check if a path is a directory
int isdirectory(char * path){
	struct stat statbuf; 
	if (stat(path, &statbuf) == -1){
		perror("Failed to verify directory");
		return 0;
	}
	return S_ISDIR(statbuf.st_mode);
}

// Set global variables for aligning outputs; uses depthfirst traversal with recursion
int setMaxDepth(char * root, int depth, int *flags ){
	// Set variable for to store path and file info
	int bufsize = 255;
	char buf[bufsize]; 
	struct dirent *dirent_ptr;

	// Open directory stream
	DIR *dir_ptr = opendir(root);

	// Default is to use current directory
	if (dir_ptr == NULL){
		root = ".";
		dir_ptr = opendir(root);
	}

	// Go through directory and loop through every file
	while ((dirent_ptr = readdir(dir_ptr)) != NULL){
		char *filename = dirent_ptr->d_name;
		int len = (int)strlen(filename);

		// Set max filename length
		if (len > max_name_global)
			max_name_global = len;
		
		// Ignore present directory and parent directory; This will prevent an infinite loop
		if ( (strcmp(filename, ".") && strcmp(filename, "..")) != 0){
			// Set buf as file path
			strcpy(buf, "");
			strcat(buf, root);
			strcat(buf, "/");
			strcat(buf, filename);

			// Get file data using struct stat
			struct stat statbuf;
			if(lstat(buf, &statbuf) == -1){
				perror("Error getting status\n");
			}
			
			if (flags[2] == 1){
				if(stat(buf, &statbuf) == -1){
					printf("%s\n", buf);
					perror("Error getting symlink stat");
					//flags[2] = 0;
				}
			}
			else{
				if(lstat(buf, &statbuf) == -1){
					perror("Error getting status\n");
				}
			}

			// Setting max depth if this depth traversal is higher than current max_depth
			//if (isdirectory(buf)){
			if (S_ISDIR(statbuf.st_mode)){
				int newdepth = depth + 1;
				setMaxDepth(buf, newdepth, flags);	
				if (newdepth > max_depth_global)
					max_depth_global = newdepth;
			}
			// Reset buffer for next iteration
			else
				strcpy(buf, "");
		}
	}
	while ((closedir(dir_ptr) == -1) && (errno == EINTR));
	return 0;
}

// Depth first traversal and print file data; while loop with recursion
int depthfirst(char *root, int maxdepth, int *flags, int indent){
	// Declare variable to store path, directory, and file info
	int bufsize = 255;
	char buf[bufsize]; 
	struct dirent *dirent_ptr;
	DIR *dir_ptr = opendir(root);
	if (dir_ptr == NULL){
		perror("Failed to open directory in depthfirst()");
		return -1;
	}

	// Print file data based on flags
	int space = 1;
	while ((dirent_ptr = readdir(dir_ptr)) != NULL){
		char *filename = dirent_ptr->d_name;
		if ( (strcmp(filename, ".") && strcmp(filename, "..")) != 0){
			int total_indents = maxdepth * indent;
			int space_used = total_indents + (int)strlen(filename); 
			printf("%*s%s%*s", total_indents, "", filename, stat_pos - space_used + indent, "");
			// Path to file that is just read
			strcpy(buf, "");
			strcat(buf, root);
			strcat(buf, "/");
			strcat(buf, filename);

			// Get file info
			struct stat statbuf;

			// Print in respect to the flags
			
			// If -L is picked get stat using lstat for following symbolic link
			if (flags[2] == 1){
				if(stat(buf, &statbuf) == -1){
					perror("Error getting symlink stat");
					flags[2] = 0;
				}
			}
			else{
				if(lstat(buf, &statbuf) == -1){
					perror("Error getting status\n");
				}
			}

			// If -t is picked; this checks only for directory
			if (flags[8] == 1){
				// Check for directory	
				if (S_ISDIR(statbuf.st_mode))
					printf("d");
				// Check for symbolic link
				else if (S_ISLNK(statbuf.st_mode))
					printf("l");
				// Check for pipes
				else if(S_ISFIFO(statbuf.st_mode))
					printf("p");
				// Check for socket
				else if(S_ISSOCK(statbuf.st_mode))
					printf("s");
				// Check for block special file
				else if(S_ISBLK(statbuf.st_mode))
					printf("b");
				// Check for character special file
				else if(S_ISCHR(statbuf.st_mode))
					printf("c");
				else
					printf("-");
			}

			// If -p is picked, print permission
			if (flags[6] == 1){
				printf( (statbuf.st_mode & S_IRUSR) ? "r" : "-");
				printf( (statbuf.st_mode & S_IWUSR) ? "w" : "-");
				printf( (statbuf.st_mode & S_IXUSR) ? "x" : "-");
				printf( (statbuf.st_mode & S_IRGRP) ? "r" : "-");
				printf( (statbuf.st_mode & S_IWGRP) ? "w" : "-");
				printf( (statbuf.st_mode & S_IXGRP) ? "x" : "-");
				printf( (statbuf.st_mode & S_IROTH) ? "r" : "-");
				printf( (statbuf.st_mode & S_IWOTH) ? "w" : "-");
				printf( (statbuf.st_mode & S_IXOTH) ? "x" : "-");
			}

			// Spacing for -t and -p
			if (flags[8] + flags[6] != 0)
				printf("%*s", space, "");

			// If -i, print number of links
			if (flags[5] == 1){
				int inode = statbuf.st_nlink;
				printf("%4d%*s", inode, space, "");
			}

			// If -u, print uid
			if (flags[9] == 1){
				struct passwd *pwd;
				if ((pwd = getpwuid(statbuf.st_uid)) != NULL)
					printf("%*s%*s", (int)strlen(pwd->pw_name) + 1, pwd->pw_name, space, "");
				else
					printf("%8d%*s", statbuf.st_uid, space, "");
			}

			// If -g, print gid
			if (flags[4] == 1){
				struct group *grp;
				if ((grp = getgrgid(statbuf.st_gid)) != NULL)
					printf("%*s%*s", (int)strlen(grp->gr_name) + 1, grp->gr_name, space, "");
				else
					printf("%8d%*s", statbuf.st_gid, space, "");
			}

			// If -s, print size of a file
			if (flags[7] == 1){
				int size = statbuf.st_size;
				char *bytes[4] = {"", "K", "M", "G"};
				int count = 0;
				char str[10];
				while(size >= 1024){
					size = size/1024;
					count++;
				}
				sprintf(str, "%d", size);
				strcat(str, bytes[count]);
				printf("%6s%*s", str, space, "");
			}

			// If -d, print date of last modification
			if (flags[3] == 1){
				char last_mod[26];
				struct tm* tm_info;
				tm_info = localtime(&statbuf.st_mtime);
				strftime(last_mod, 26, "%b %d, %Y", tm_info);
				printf("%*s", (int)strlen(last_mod) + 2, last_mod);
			}

			// If current file is a directory, use recursion to get into subdirectory
			//if (isdirectory(buf)){
			if (S_ISDIR(statbuf.st_mode)){
				printf("\n");
				int newdepth = maxdepth + 1;
				depthfirst(buf, newdepth, flags, indent);	
			}
			else
				printf("\n");
			// Reset buffer a the end of every iteration
			strcpy(buf, "");
		}
	}
	// Close all directory streams
	while ((closedir(dir_ptr) == -1) && (errno == EINTR));
	return 0;
}
