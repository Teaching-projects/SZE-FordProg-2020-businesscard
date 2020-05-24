%{
  #include <stdio.h>
  #include <string.h>
  int yylex();
  int yyerror(char* message){
    return 1;
  };

  int i=0;

  struct Contact {
    char* name;
    char* address;
    char* email;
    char* phone_number;
    char* company;
    char* company_address;
    char* company_phone;
    char* company_email;
    char* company_post;
  };

  struct Contact contact_array[999];
  void print_contact_list(int len);
  char* copy_element_content(char* str, char* new);

%}

%union{
  char *a;
  int fn;
}

%token NUMBER
%token STRING
%token NAME_VALUE
%token PHONE_VALUE
%token EMAIL_VALUE
%token ADDRESS_VALUE
%token NAME
%token ADDRESS
%token EMAIL
%token PHONE
%token COMPANY
%token COMPANY_ADDRESS
%token COMPANY_PHONE
%token COMPANY_EMAIL
%token COMPANY_POST
%token ARRAY_BEGIN
%token ARRAY_END
%token OBJECT_BEGIN
%token OBJECT_END



%%

objects     : OBJECT_BEGIN commands OBJECT_END {print_contact_list(i);} '\n' objects
            | OBJECT_BEGIN commands OBJECT_END ',' objects
            | /* */
            ;

commands    : name { contact_array[i].name=$<a>1; } ',' commands
            | name {contact_array[i].name=$<a>1; i++;  }

            | address { contact_array[i].address=$<a>1; } ',' commands
            | address { contact_array[i].address=$<a>1; i++; }

            | email { contact_array[i].email=$<a>1; } ',' commands
            | email { contact_array[i].email=$<a>1; i++; }

            | phone { contact_array[i].phone_number=$<a>1; } ',' commands
            | phone { contact_array[i].phone_number=$<a>1; i++; }

            | company { contact_array[i].company=$<a>1; } ',' commands
            | company { contact_array[i].company=$<a>1; i++; }

            | company_address { contact_array[i].company_address=$<a>1; } ',' commands
            | company_address { contact_array[i].company_address=$<a>1; i++; }

            | company_phone { contact_array[i].company_phone=$<a>1; } ',' commands
            | company_phone { contact_array[i].company_phone=$<a>1; i++; }

            | company_email { contact_array[i].company_email=$<a>1; } ',' commands
            | company_email { contact_array[i].company_email=$<a>1; i++; }

            | company_post { contact_array[i].company_post=$<a>1; } ',' commands
            | company_post { contact_array[i].company_post=$<a>1; i++; }

            | /**/


            ;

name        : NAME ':' NAME_VALUE {$<a>$ = $<a>3;}
            | NAME ':' name_array {$<a>$ = $<a>3;}
            ;

address     : ADDRESS ':' ADDRESS_VALUE {$<a>$ = $<a>3;}
            | ADDRESS ':' address_array {$<a>$ = $<a>3;}
            ;

email       : EMAIL ':' EMAIL_VALUE {$<a>$ = $<a>3;}
            | EMAIL ':' email_array {$<a>$ = $<a>3;}
            ;

phone       : PHONE ':' PHONE_VALUE {$<a>$ = $<a>3;}
            | PHONE ':' phone_array {$<a>$ = $<a>3;}
            ;

company     : COMPANY ':' ADDRESS_VALUE {$<a>$ = $<a>3;}
            | COMPANY ':' NAME_VALUE {$<a>$ = $<a>3;}
            | COMPANY ':' address_array {$<a>$ = $<a>3;}
            | COMPANY ':' name_array {$<a>$ = $<a>3;}
            ;

company_address : COMPANY_ADDRESS ':' ADDRESS_VALUE {$<a>$ = $<a>3;}
                | COMPANY_ADDRESS ':' address_array {$<a>$ = $<a>3;}
                ;

company_phone   : COMPANY_PHONE ':' PHONE_VALUE {$<a>$ = $<a>3;}
                | COMPANY_PHONE ':' phone_array {$<a>$ = $<a>3;}
                ;

company_email   : COMPANY_EMAIL ':' EMAIL_VALUE {$<a>$ = $<a>3;}
                | COMPANY_EMAIL ':' email_array {$<a>$ = $<a>3;}
                ;

company_post    : COMPANY_POST ':' NAME_VALUE {$<a>$ = $<a>3;}
                | COMPANY_POST ':' name_array {$<a>$ = $<a>3;}
                ;

/**/

name_array      : ARRAY_BEGIN ARRAY_END
                | ARRAY_BEGIN name_elements ARRAY_END {$<a>$ = $<a>2}
                ;

address_array   : ARRAY_BEGIN ARRAY_END
                | ARRAY_BEGIN address_elements ARRAY_END {$<a>$ = $<a>2}
                ;

phone_array     : ARRAY_BEGIN ARRAY_END
                | ARRAY_BEGIN phone_elements ARRAY_END {$<a>$ = $<a>2}
                ;

email_array     : ARRAY_BEGIN ARRAY_END
                | ARRAY_BEGIN email_elements ARRAY_END {$<a>$ = $<a>2}
                ;

/**/

name_elements      : NAME_VALUE {$<a>$ = $<a>1;}
                   | NAME_VALUE ',' name_elements { $<a>$ = copy_element_content($<a>1, $<a>3); }
                   ;

address_elements   : ADDRESS_VALUE {$<a>$ = $<a>1;}
                   | ADDRESS_VALUE ',' address_elements { $<a>$ = copy_element_content($<a>1, $<a>3); }
                   ;

phone_elements     : PHONE_VALUE {$<a>$ = $<a>1;}
                   | PHONE_VALUE ',' phone_elements { $<a>$ = copy_element_content($<a>1, $<a>3); }
                   ;

email_elements     : EMAIL_VALUE {$<a>$ = $<a>1;}
                   | EMAIL_VALUE ',' email_elements { $<a>$ = copy_element_content($<a>1, $<a>3); }
                   ;

%%


int main(){
  if (yyparse() == 0) printf("<ACC>\n");
  else printf("ERROR\n");
  return 0;
}

char* copy_element_content(char* str, char* new){
  char * str3 = (char *) malloc(1+strlen(str)+strlen(new)+1);
  strcpy(str3, str);
  strcat(str3, " ");
  strcat(str3, new);
  return str3;
}

void print_contact_list(int len){
  printf("*******\n");
  printf("Printing contact list");
  int i;
  for (i = 0; i<len; i++){
    printf("\nContact %d:\n", i+1);
    if (contact_array[i].name != '\0')  printf("Name: %s\n", contact_array[i].name);
    if (contact_array[i].company_post != '\0')  printf("Title: %s\n", contact_array[i].company_post);
    if (contact_array[i].address != '\0')  printf("Address: %s\n", contact_array[i].address);
    if (contact_array[i].email != '\0')  printf("E-Mail: %s\n", contact_array[i].email);
    if (contact_array[i].phone_number != '\0')  printf("Phone: %s\n", contact_array[i].phone_number);
    if (contact_array[i].company != '\0')  printf("Company: %s\n", contact_array[i].company);
    if (contact_array[i].company_address != '\0')  printf("Company Address: %s\n", contact_array[i].company_address);
    if (contact_array[i].company_email != '\0')  printf("Company E-Mail: %s\n", contact_array[i].company_email);
    if (contact_array[i].company_phone != '\0')  printf("Company Phone: %s\n", contact_array[i].company_phone);
    printf("----\n");
  }
}
