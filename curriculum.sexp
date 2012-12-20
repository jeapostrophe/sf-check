((Basics
  ((nandb 1 #f #f (nandb test_nandb1 test_nandb2 test_nandb3 test_nandb4))
   (andb3 1 #f #f (andb3 test_andb31 test_andb32 test_andb33 test_andb34))
   (factorial 1 #f #f (factorial test_factorial1 test_factorial2))
   (blt_nat 2 #f #f (blt_nat test_blt_nat1 test_blt_nat2 test_blt_nat3))
   (simpl_plus 1 optional #t (simpl_plus))
   (plus_id_exercise 1 #f #f (plus_id_exercise))
   (mult_1_plus 2 recommended #f (mult_1_plus))
   (zero_nbeq_plus_1 1 #f #f (zero_nbeq_plus_1))
   (andb_true_elim2 2 #f #f (andb_true_elim2))
   (basic_induction 2 recommended #f (mult_0_r plus_n_Sm plus_comm))
   (double_plus 2 #f #f (double_plus))
   (destruct_induction 1 #f #t (destruct_induction))
   (plus_comm_informal 2 #f #t (plus_comm_informal))
   (beq_nat_refl_informal 2 optional #t (beq_nat_refl_informal))
   (beq_nat_refl 1 optional #f (beq_nat_refl))
   (mult_comm 4 recommended #f (plus_swap mult_comm))
   (evenb_n__oddb_Sn 2 optional #f (evenb_n__oddb_Sn))
   (more_exercises
    3
    optional
    #f
    (ble_nat_refl
     zero_nbeq_S
     andb_false_r
     plus_ble_compat_l
     S_nbeq_0
     mult_1_l
     all3_spec
     mult_plus_distr_r
     mult_assoc))
   (|plus_swap'| 2 optional #f (|plus_swap'|))
   (binary 4 recommended #t (binary))
   (binary_inverse 5 #f #t (binary_inverse))
   (decreasing 2 optional #t (decreasing))))
 (Lists
  ((snd_fst_is_swap 1 #f #f (snd_fst_is_swap))
   (fst_swap_is_snd 1 optional #f (fst_swap_is_snd))
   (list_funs
    2
    recommended
    #f
    (nonzeros
     test_nonzeros
     oddmembers
     test_oddmembers
     countoddmembers
     test_countoddmembers1
     test_countoddmembers2
     test_countoddmembers3))
   (alternate
    3
    recommended
    #f
    (alternate
     test_alternate1
     test_alternate2
     test_alternate3
     test_alternate4))
   (bag_functions
    3
    recommended
    #f
    (count
     test_count1
     test_count2
     sum
     test_sum1
     add
     test_add1
     test_add2
     member
     test_member1
     test_member2))
   (bag_more_functions
    3
    optional
    #f
    (remove_one
     test_remove_one1
     test_remove_one2
     test_remove_one3
     test_remove_one4
     remove_all
     test_remove_all1
     test_remove_all2
     test_remove_all3
     test_remove_all4
     subset
     test_subset1
     test_subset2))
   (bag_theorem 3 recommended #t (bag_theorem))
   (list_exercises
    3
    recommended
    #f
    (app_nil_end
     rev_involutive
     app_ass4
     snoc_append
     distr_rev
     nonzeros_length))
   (list_design 2 recommended #t (list_design))
   (bag_proofs 2 optional #f (count_member_nonzero remove_decreases_count))
   (bag_count_sum 3 optional #t (bag_count_sum))
   (rev_injective 4 optional #t (rev_injective))
   (hd_opt 2 #f #f (hd_opt test_hd_opt1 test_hd_opt2 test_hd_opt3))
   (option_elim_hd 1 optional #f (option_elim_hd))
   (beq_natlist
    2
    recommended
    #f
    (beq_natlist
     test_beq_natlist1
     test_beq_natlist2
     test_beq_natlist3
     beq_natlist_refl))
   (dictionary_invariant1 1 #f #f (dictionary_invariant1))
   (dictionary_invariant2 1 #f #f (dictionary_invariant2))))
 (Poly
  ((poly_exercises
    2
    optional
    #f
    (repeat test_repeat1 nil_app rev_snoc rev_involutive snoc_with_append))
   (combine_checks 1 optional #t (combine_checks))
   (split 2 recommended #f (split test_split))
   (hd_opt_poly 1 optional #f (hd_opt test_hd_opt1 test_hd_opt2))
   (currying 2 optional #f (prod_uncurry uncurry_curry curry_uncurry))
   (filter_even_gt7
    2
    #f
    #f
    (filter_even_gt7 test_filter_even_gt7_1 test_filter_even_gt7_2))
   (partition 3 #f #f (partition test_partition1 test_partition2))
   (map_rev 3 optional #f (map_rev))
   (flat_map 2 recommended #f (flat_map test_flat_map1))
   (implicit_args 2 optional #t (implicit_args))
   (fold_types_different 1 optional #t (fold_types_different))
   (override_example 1 #f #f (override_example))
   (silly_ex 2 optional #f (silly_ex))
   (apply_exercise1 3 recommended #f (rev_exercise1))
   (apply_rewrite 1 #f #t (apply_rewrite))
   (override_neq 2 #f #f (override_neq))
   (sillyex1 1 #f #f (sillyex1))
   (sillyex2 1 #f #f (sillyex2))
   (beq_nat_eq_informal 2 #f #t (beq_nat_eq_informal))
   (|beq_nat_eq'| 3 #f #f (|beq_nat_eq'|))
   (practice 2 optional #f (beq_nat_0_l beq_nat_0_r))
   (apply_exercise2 3 #f #f (beq_nat_sym))
   (beq_nat_sym_informal 3 #f #t (beq_nat_sym_informal))
   (plus_n_n_injective 3 recommended #f (plus_n_n_injective))
   (override_shadow 1 #f #f (override_shadow))
   (combine_split 3 recommended #f (combine_split))
   (split_combine 3 optional #t (split_combine))
   (override_same 2 #f #f (override_same))
   (filter_exercise 3 optional #f (filter_exercise))
   (apply_exercises
    3
    recommended
    #f
    (trans_eq_exercise beq_nat_trans override_permute))
   (fold_length 2 optional #f (fold_length_correct))
   (fold_map 3 recommended #t (fold_map))
   (mumble_grumble 2 optional #t (mumble_grumble))
   (baz_num_elts 2 optional #t (baz_num_elts))
   (forall_exists_challenge 4 recommended #t (forall_exists_challenge))
   (index_informal 2 optional #t (index_informal))))
 (Gen
  ((gen_dep_practice
    3
    recommended
    #f
    (plus_n_n_injective_take2 index_after_last))
   (index_after_last_informal 3 optional #t (index_after_last_informal))
   (gen_dep_practice_opt 3 #f #f (|length_snoc'''|))
   (app_length_cons 3 #f #f (app_length_cons))
   (app_length_twice 4 optional #f (app_length_twice))))
 (Prop
  ((varieties_of_beauty 1 #f #t (varieties_of_beauty))
   (six_is_beautiful 1 #f #f (six_is_beautiful |six_is_beautiful'|))
   (nine_is_beautiful 1 #f #f (nine_is_beautiful |nine_is_beautiful'|))
   (b_times2 2 #f #f (b_times2))
   (|b_times2'| 3 optional #f (|b_times2'|))
   (b_timesm 2 #f #f (b_timesm))
   (gorgeous_tree 1 #f #t (gorgeous_tree))
   (gorgeous_plus13 1 #f #f (gorgeous_plus13))
   (gorgeous_plus13_po 2 #f #f (gorgeous_plus13_po))
   (gorgeous_sum 2 #f #f (gorgeous_sum))
   (beautiful__gorgeous 3 #f #f (beautiful__gorgeous))
   (b_times2 3 optional #f (helper_g_times2 g_times2))
   (double_even 1 #f #f (double_even))
   (double_even_pfobj 4 optional #t (double_even_pfobj))
   (ev_minus2_n 1 optional #t (ev_minus2_n))
   (ev__even 1 recommended #t (ev__even))
   (l_fails 1 #f #t (l_fails))
   (ev_sum 2 #f #f (ev_sum))
   (inversion_practice 1 #f #f (SSSSev__even))
   (ev_ev__ev 3 recommended #f (ev_ev__ev))
   (ev_plus_plus 3 optional #f (ev_plus_plus))
   (|plus_one_r'| 2 optional #f (|plus_one_r'|))
   (rgb 1 #f #t (rgb))
   (natlist1 1 #f #t (natlist1))
   (ex_set 1 #f #t (ex_set))
   (tree 1 #f #t (tree))
   (mytype 1 #f #t (mytype))
   (foo 1 optional #t (foo))
   (|foo'| 1 optional #t (|foo'|))
   (p_provability 3 optional #t (p_provability))
   (plus_explicit_prop 1 optional #t (plus_explicit_prop))
   (true_upto_n__true_everywhere 4 optional #t (true_upto_n__true_everywhere))
   (palindromes 4 recommended #t (palindromes))
   (palindrome_converse 5 optional #t (palindrome_converse))
   (subsequence 4 #f #t (subsequence))
   (foo_ind_principle 2 optional #t (foo_ind_principle))
   (bar_ind_principle 2 optional #t (bar_ind_principle))
   (no_longer_than_ind 2 optional #t (no_longer_than_ind))
   (R_provability 2 optional #t (R_provability))))
 (Logic
  ((proj2 1 optional #f (proj2))
   (and_assoc 2 #f #f (and_assoc))
   (even__ev 2 recommended #f (even__ev))
   (conj_fact 2 optional #f (conj_fact))
   (iff_properties 1 optional #f (iff_refl iff_trans))
   (beautiful_iff_gorgeous 2 optional #f (beautiful_iff_gorgeous))
   (|or_commut''| 2 optional #t (|or_commut''|))
   (or_distributes_over_and_2 2 recommended #f (or_distributes_over_and_2))
   (or_distributes_over_and 1 optional #f (or_distributes_over_and))
   (bool_prop 2 #f #f (andb_false orb_true orb_false))
   (False_ind_principle 1 #f #t (False_ind_principle))
   (True_induction 2 optional #t (True_induction))
   (double_neg_inf 2 recommended #t (double_neg_inf))
   (contrapositive 2 recommended #f (contrapositive))
   (not_both_true_and_false 1 #f #f (not_both_true_and_false))
   (informal_not_PNP 1 #f #t (informal_not_PNP))
   (ev_not_ev_S 1 #f #f (ev_not_ev_S))
   (classical_axioms 5 optional #t (classical_axioms))
   (not_eq_beq_false 2 recommended #f (not_eq_beq_false))
   (beq_false_not_eq 2 optional #f (beq_false_not_eq))
   (english_exists 1 optional #t (english_exists))
   (dist_not_exists 1 #f #f (dist_not_exists))
   (not_exists_dist 3 optional #f (not_exists_dist))
   (dist_exists_or 2 #f #f (dist_exists_or))
   (two_defs_of_eq_coincide 3 optional #f (two_defs_of_eq_coincide))
   (total_relation 2 recommended #t (total_relation))
   (empty_relation 2 #f #t (empty_relation))
   (R_provability 3 recommended #t (R_provability))
   (R_fact 3 optional #t (R_fact))
   (all_forallb 3 recommended #t (all_forallb))
   (filter_challenge 4 optional #t (filter_challenge))
   (filter_challenge_2 5 optional #t (filter_challenge_2))
   (no_repeats 4 optional #t (no_repeats appears_in_app app_appears_in))
   (le_exercises
    2
    optional
    #f
    (O_le_n
     n_le_m__Sn_le_Sm
     Sn_le_Sm__n_le_m
     le_plus_l
     plus_lt
     lt_S
     ble_nat_true
     ble_nat_n_Sn_false
     ble_nat_false))
   (nostutter
    3
    recommended
    #f
    (nostutter test_nostutter_1 test_nostutter_2 test_nostutter_3 test_nostutter_4))
   (|pigeonhole principle|
    4
    optional
    #f
    (app_length appears_in_app_split repeats pigeonhole_principle))
   (and_ind_principle 1 optional #t (and_ind_principle))
   (or_ind_principle 1 optional #t (or_ind_principle))))
 (Imp
  ((optimize_0plus_b 3 #f #t ())
   (optimizer 4 optional #t ())
   (bevalR 3 #f #t ())
   (beq_id_eq 1 optional #f (beq_id_eq))
   (beq_id_false_not_eq 1 optional #f (beq_id_false_not_eq))
   (not_eq_beq_id_false 1 optional #f (not_eq_beq_id_false))
   (beq_id_sym 1 optional #f (beq_id_sym))
   (update_eq 1 #f #f (update_eq))
   (update_neq 1 #f #f (update_neq))
   (update_example 1 #f #f (update_example))
   (update_shadow 1 recommended #f (update_shadow))
   (update_same 2 #f #f (update_same))
   (update_permute 3 #f #f (update_permute))
   (ceval_example2 2 #f #f (ceval_example2))
   (pup_to_n 3 optional #f (pup_to_n pup_to_2_ceval))
   (XtimesYinZ_spec 3 recommended #t ())
   (loop_never_stops 3 recommended #f (loop_never_stops))
   (no_whilesR 3 optional #f (no_whiles_eqv))
   (no_whiles_terminating 4 optional #t ())
   (subtract_slowly_spec 4 optional #t ())
   (add_for_loop 4 optional #t ())
   (short_circuit 3 optional #t ())
   (stack_compiler
    4
    recommended
    #f
    (s_execute s_execute1 s_execute2 s_compile s_compile_correct))))
 (ImpCEvalFun
  ((pup_to_n 2 recommended #f (pup_to_n))
   (peven 2 optional #t ())
   (ceval_step__ceval_inf 4 #f #t ())
   (ceval__ceval_step 3 recommended #f (ceval__ceval_step))))
 (Equiv
  ((pairs_equiv 2 optional #t ())
   (equiv_classes 3 #f #t ())
   (skip_right 2 #f #f (skip_right))
   (IFB_false 2 recommended #f (IFB_false))
   (swap_if_branches 3 #f #f (swap_if_branches))
   (WHILE_false_informal 2 #f #t ())
   (WHILE_true_nonterm_informal 2 optional #t ())
   (WHILE_true 2 recommended #f (WHILE_true))
   (seq_assoc 2 optional #f (seq_assoc identity_assignment_first_try))
   (assign_aequiv 2 recommended #f (assign_aequiv))
   (functional_extensionality_failed_false 2 optional #t ())
   (CSeq_congruence 3 optional #f (CSeq_congruence))
   (CIf_congruence 3 #f #f (CIf_congruence))
   (fold_bexp_BEq_informal 3 optional #f (fold_constants_bexp_sound))
   (fold_constants_com_sound 3 #f #f (fold_constants_com_sound))
   (optimize_0plus 4 optional #t ())
   (better_subst_equiv 4 optional #f (aeval_weakening))
   (inequiv_exercise 3 recommended #f (inequiv_exercise))
   (himp_ceval 2 #f #f (havoc_example1 havoc_example2))
   (havoc_swap 3 #f #f (pXY_cequiv_pYX))
   (havoc_copy 4 #f #f (ptwice_cequiv_pcopy))
   (havoc_diverge 5 optional #f (p1_p2_equiv p3_p4_inequiv p5_p6_equiv))
   (stequiv_refl 1 optional #f (stequiv_refl))
   (stequiv_sym 1 optional #f (stequiv_sym))
   (stequiv_trans 1 optional #f (stequiv_trans))
   (stequiv_update 1 optional #f (stequiv_update))
   (stequiv_aeval 2 optional #f (stequiv_aeval))
   (stequiv_beval 2 optional #f (stequiv_beval))
   (|identity_assignment'| 2 optional #f (|identity_assignment'|))
   (for_while_equiv 4 optional #t ())
   (swap_noninterfering_assignments
    3
    optional
    #f
    (swap_noninterfering_assignments))))
 (Hoare
  ((assertions 1 #f #t ())
   (triples 1 #f #t ())
   (valid_triples 1 #f #t ())
   (wp 1 #f #t ())
   (is_wp_formal 3 optional #f (is_wp_example))
   (hoare_asgn_examples 2 #f #t ())
   (hoare_asgn_wrong 2 #f #t ())
   (hoare_asgn_fwd 3 optional #f (hoare_asgn_fwd))
   (hoare_asgn_weakest 2 #f #f (hoare_asgn_weakest silly1 silly2))
   (hoare_asgn_examples_2 2 #f #t ())
   (hoare_asgn_example4 2 #f #f (hoare_asgn_example4))
   (swap_exercise 3 #f #t ())
   (hoarestate1 3 optional #t ())
   (if1_hoare 4 recommended #f (hoare_if1_good))
   (hoare_repeat 4 #f #f (ex1_repeat_works))
   (himp_hoare 3 #f #f (havoc_pre hoare_havoc hoare_havoc_weakest))
   (reduce_to_zero_correct 2 #f #f (reduce_to_zero_correct))
   (add_slowly_decoration 3 #f #t ())
   (add_slowly_formal 3 #f #t ())
   (wrong_find_parity_invariant 2 #f #t ())
   (sqrt_informal 3 #f #t ())
   (fact_informal 3 optional #t ())
   (fact_formal 4 optional #f (fact_com_correct))
   (slow_assignment_dec
    3
    optional
    #f
    (slow_assignment_dec slow_assignment_dec_correct))
   (factorial_dec 4 optional #t ())))
 (Rel
  ((#f 2 optional #t ())
   (#f 2 optional #t ())
   (#f 2 optional #f (|lt_trans'|))
   (#f 2 optional #f (|lt_trans''|))
   (#f 1 optional #f (le_S_n))
   (le_Sn_n_inf 2 optional #t ())
   (#f 1 optional #f (le_Sn_n))
   (#f 2 optional #f (le_not_symmetric))
   (#f 2 optional #f (le_antisymmetric))
   (#f 2 optional #f (le_step))
   (rsc_trans 2 optional #f (rsc_trans))
   (rtc_rsc_coincide 3 optional #f (rtc_rsc_coincide))))
 (Smallstep
  ((test_step_2 2 #f #f (test_step_2))
   (redo_determinism 3 recommended #t ())
   (step_deterministic 2 optional #f (step_deterministic))
   (value_not_same_as_normal_form
    3
    optional
    #f
    (value_not_same_as_normal_form))
   (value_not_same_as_normal_form
    2
    optional
    #f
    (value_not_same_as_normal_form))
   (|value_not_same_as_normal_form'| 3 #f #f (value_not_same_as_normal_form))
   (smallstep_bools 1 #f #t ())
   (progress_bool 3 recommended #f (strong_progress))
   (step_deterministic 2 optional #f (step_deterministic))
   (smallstep_bool_shortcut 2 #f #f (bool_step_prop4_holds))
   (properties_of_altered_step 3 optional #t ())
   (test_multistep_2 1 optional #f (test_multistep_2))
   (test_multistep_3 1 optional #f (test_multistep_3))
   (test_multistep_4 2 #f #f (test_multistep_4))
   (normal_forms_unique 3 optional #f (normal_forms_unique))
   (multistep_congr_2 2 #f #f (multistep_congr_2))
   (eval__multistep 3 #f #f (eval__multistep))
   (eval__multistep_inf 3 #f #t ())
   (step__eval 3 #f #f (step__eval))
   (multistep__eval 3 #f #f (multistep__eval))
   (combined_properties 4 #f #t ())
   (#f 3 optional #f (par_body_n__Sn))
   (#f 3 optional #f (par_body_n))))
 (Types
  ((normalize_ex 1 #f #f (normalize_ex))
   (|normalize_ex'| 1 optional #f (|normalize_ex'|))
   (some_term_is_stuck 2 #f #f (some_term_is_stuck))
   (value_is_nf 3 optional #f (value_is_nf))
   (step_deterministic 3 optional #f (step_deterministic))
   (succ_hastype_nat__hastype_nat 1 #f #f (succ_hastype_nat__hastype_nat))
   (finish_progress_informal 3 recommended #t ())
   (finish_progress 3 #f #f (progress))
   (step_review 1 #f #t ())
   (finish_preservation_informal 3 recommended #t ())
   (finish_preservation 2 #f #f (preservation))
   (preservation_alternate_proof 3 #f #f (|preservation'|))
   (subject_expansion 2 recommended #t ())
   (variation1 2 #f #t ())
   (variation2 2 #f #t ())
   (variation3 2 #f #t ())
   (variation4 2 #f #t ())
   (variation5 2 #f #t ())
   (variation6 2 #f #t ())
   (variation7 2 #f #t ())
   (variation8 2 #f #t ())
   (more_variations 3 optional #t ())
   (remove_predzero 1 #f #t ())
   (prog_pres_bigstep 4 optional #t ())))
 (Stlc
  ((step_example3 2 #f #f (step_example3))
   (typing_example_2_full 2 optional #f (typing_example_2_full))
   (typing_example_3 2 #f #f (typing_example_3))
   (typing_nonexample_3 3 #f #f (typing_nonexample_3))
   (typing_statements 1 optional #t ())
   (more_typing_statements 1 #f #t ())
   (progress_from_term_ind 3 optional #f (|progress'|))
   (typable_empty__closed 2 #f #f (typable_empty__closed))
   (subject_expansion_stlc 2 recommended #t ())
   (type_soundness 2 optional #f (soundness))
   (types_unique 3 #f #t ())
   (progress_preservation_statement 1 #f #t ())
   (stlc_variation1 2 #f #t ())
   (stlc_variation2 2 #f #t ())
   (stlc_variation3 2 #f #t ())
   (stlc_variation4 2 #f #t ())
   (stlc_variation5 2 #f #t ())
   (stlc_variation6 2 #f #t ())
   (stlc_variation7 2 #f #t ())
   (|STLC with Arithmetic| #f optional #t ())
   (stlc_arith 4 optional #t ())))
 (MoreStlc
  ((halve_fix 1 #f #t ())
   (fact_steps 1 recommended #t ())
   (STLC_extensions 4 recommended #t ()))))
