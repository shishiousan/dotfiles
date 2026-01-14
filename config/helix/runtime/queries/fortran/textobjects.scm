
; class objects

((program
  (program_statement)
  .
  (_)+ @class.inside
  .
  (end_program_statement))) @class.around

((module
  (module_statement)
  .
  (_)+ @class.inside
  .
  (end_module_statement))) @class.around


((submodule
  (submodule_statement)
  .
  (_)+ @class.inside
  .
  (end_submodule_statement))) @class.around

((derived_type_definition
  (derived_type_statement)
  .
  (_)+ @class.inside
  . 
  [
  (derived_type_procedures)
  (end_type_statement)
  ])) @class.around
  
((derived_type_procedures
  (contains_statement)
  .
  (_)+ @class.inside
  . 
  )) 
  

; function objects

((module_procedure
   (module_procedure_statement)
   .
   (_)+ @function.inside
   .
   (end_module_procedure_statement))) @function.around

((function
   (function_statement)
   .
   (_)+ @function.inside
   .
   (end_function_statement))) @function.around

((subroutine
   (subroutine_statement)
   .
   (_)+ @function.inside
   .
   (end_subroutine_statement))) @function.around

; entry objects (used for conditional and loop )

; ((do_loop_statement
;   (_)
;   . 
;   (_)+ @entry.inside
;   .
;   (end_do_loop_statement))) @entry.around
;   
;
; (if_statement) @entry.around
;
; ((if_statement
;    (parenthesized_expression)
;    . 
;    (_)+ @entry.inside
;    .
;    [
;     (elseif_clause)
;     (else_clause)
;     (end_if_statement)
;    ]))
;
; ((elseif_clause 
;   (parenthesized_expression)
;   . 
;   (_)+ @entry.inside
;   .
;   ))
;   
;
; ((else_clause 
;   . 
;   (_)+ @entry.inside
;   .
;   ))
;
; (select_case_statement) @entry.around
;
; (select_case_statement
;    (selector)
;    . 
;    (_)+ @entry.inside
;    .
;    [
;    (end_select_statement)
;    (case_statement)
;    ]) @entry.around
;
; ((case_statement 
;   (_)
;   . 
;   (_)+ @entry.inside
;   .
;   ))
;
; (select_type_statement) @entry.around
;
; (select_type_statement
;    (selector)
;    . 
;    (_)+ @entry.inside
;    .
;    [
;    (end_select_statement)
;    (type_statement)
;    ])
;
; ((type_statement 
;   (_)
;   . 
;   (_)+ @entry.inside
;   .
;   ))
;
; ; test objects used for block
;
; (block_construct) @test.around
;
; ((block_construct
;    .
;    (_)+ @test.inside
;    .
;    (end_block_construct_statement)))
