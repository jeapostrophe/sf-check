((Basics
  ((nandb 1 #f #f (nandb test_nandb1 test_nandb2 test_nandb3 test_nandb4))
   (andb3 1 #f #f (andb3 test_andb31 test_andb32 test_andb33 test_andb34))
   (factorial 1 #f #f (factorial test_factorial1 test_factorial2))
   (blt_nat 2 #f #f (blt_nat test_blt_nat1 test_blt_nat2 test_blt_nat3))
   (simpl_plus 1 optional #t ())
   (plus_id_exercise 1 #f #f (plus_id_exercise))
   (mult_1_plus 2 recommended #f (mult_1_plus plus_1_neq_0_firsttry))
   (zero_nbeq_plus_1 1 #f #f (zero_nbeq_plus_1))
   (andb_true_elim2
    2
    #f
    #f
    (andb_true_elim2 plus_0_r_firsttry plus_0_r_secondtry))
   (basic_induction 2 recommended #f (mult_0_r plus_n_Sm plus_comm))
   (double_plus 2 #f #f (double_plus))
   (destruct_induction 1 #f #t ())
   (plus_comm_informal 2 #f #t ())
   (beq_nat_refl_informal 2 optional #t ())
   (beq_nat_refl 1 optional #f (beq_nat_refl plus_rearrange_firsttry))
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
   (binary 4 recommended #t ())
   (binary_inverse 5 #f #t ())
   (decreasing 2 optional #t ())))
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
     test_alternate4
     bag
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
   (bag_theorem 3 recommended #f (rev_length_firsttry))
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
   (list_design 2 recommended #t ())
   (bag_proofs 2 optional #f (count_member_nonzero remove_decreases_count))
   (bag_count_sum 3 optional #t ())
   (rev_injective 4 optional #t ())
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
   (Dictionaries #f extended #t ())
   (dictionary_invariant1 1 #f #f (dictionary_invariant1))
   (dictionary_invariant2 1 #f #f (dictionary_invariant2))))
 (Poly
  ((combine_checks 1 optional #t ())
   (split 2 recommended #t ())
   (hd_opt_poly
    1
    optional
    #f
    (hd_opt
     test_hd_opt1
     test_hd_opt2
     doit3times
     uncurry_curry
     curry_uncurry
     length_is_1
     test_filter_even_gt7_1
     test_filter_even_gt7_2))
   (partition 3 #f #f (partition test_partition1 test_partition2))
   (map_rev 3 optional #f (map_rev))
   (flat_map 2 recommended #f (flat_map test_flat_map1))
   (implicit_args 2 optional #t ())
   (fold_types_different 1 optional #f (constfun))
   (silly_ex 2 optional #f (silly_ex silly3_firsttry))
   (apply_exercise1 3 recommended #f (rev_exercise1))
   (apply_rewrite 1 #f #f (unfold_example_bad))
   (override_neq 2 #f #f (override_neq))
   (sillyex1 1 #f #f (sillyex1))
   (sillyex2 1 #f #f (sillyex2 beq_nat_eq_FAILED))
   (beq_nat_eq_informal 2 #f #t ())
   (|beq_nat_eq'| 3 #f #f (|beq_nat_eq'|))
   (practice 2 optional #f (beq_nat_0_l beq_nat_0_r))
   (apply_exercise2 3 #f #f (beq_nat_sym))
   (beq_nat_sym_informal 3 #f #t ())
   (plus_n_n_injective 3 recommended #f (plus_n_n_injective sillyfun))
   (combine_split 3 recommended #f (combine_split))
   (split_combine 3 optional #f (sillyfun1))
   (override_same 2 #f #f (override_same))
   (filter_exercise 3 optional #f (filter_exercise))
   (apply_exercises
    3
    recommended
    #f
    (trans_eq_exercise beq_nat_trans override_permute))
   (fold_length 2 optional #f (fold_length))
   (fold_map 3 recommended #f (fold_map))
   (mumble_grumble 2 optional #t ())
   (baz_num_elts 2 optional #t ())
   (forall_exists_challenge 4 recommended #t ())
   (index_informal 2 optional #t ())))
 (Gen
  ((gen_dep_practice
    3
    recommended
    #f
    (plus_n_n_injective_take2 index_after_last))
   (index_after_last_informal 3 optional #t ())
   (gen_dep_practice_opt 3 #f #f (|length_snoc'''|))
   (app_length_cons 3 #f #f (app_length_cons))
   (app_length_twice 4 optional #f (app_length_twice))))
 (Prop
  ((varieties_of_beauty 1 #f #f (|eight_is_beautiful'''| |six_is_beautiful'|))
   (nine_is_beautiful
    1
    #f
    #f
    (nine_is_beautiful |nine_is_beautiful'| |b_plus3'|))
   (|b_times2'| 3 optional #f (|b_times2'|))
   (b_timesm 2 #f #f (b_timesm))
   (gorgeous_tree 1 #f #f (gorgeous__beautiful_FAILED))
   (gorgeous_plus13 1 #f #f (gorgeous_plus13))
   (gorgeous_plus13_po 2 #f #f (gorgeous_plus13_po))
   (gorgeous_sum 2 #f #f (gorgeous_sum))
   (beautiful__gorgeous 3 #f #f (beautiful__gorgeous))
   (b_times2 3 optional #f (helper_g_times2 g_times2 even))
   (double_even_pfobj 4 optional #t ())
   (ev_minus2_n 1 optional #t ())
   (ev__even 1 recommended #t ())
   (l_fails 1 #f #t ())
   (ev_sum 2 #f #f (ev_sum SSev_ev_firsttry))
   (inversion_practice 1 #f #f (SSSSev__even even5_nonsense))
   (ev_ev__ev 3 recommended #f (ev_ev__ev))
   (ev_plus_plus 3 optional #f (ev_plus_plus plus_fact))
   (rgb 1 #f #t ())
   (natlist1 1 #f #t ())
   (ex_set 1 #f #t ())
   (tree 1 #f #t ())
   (mytype 1 #f #t ())
   (foo 1 optional #t ())
   (|foo'| 1 optional #f (P_m0r b_16_atmpt_2 b_16_atmpt_3))))
 (Logic
  ((and_assoc 2 #f #f (and_assoc))
   (even__ev 2 recommended #f (even__ev))
   (conj_fact 2 optional #f (conj_fact iff iff_trans))
   (beautiful_iff_gorgeous 2 optional #f (beautiful_iff_gorgeous))
   (|or_commut''| 2 optional #t ())
   (or_distributes_over_and_2 2 recommended #f (or_distributes_over_and_2))
   (or_distributes_over_and 1 optional #f (or_distributes_over_and))
   (bool_prop 2 #f #f (andb_false orb_true orb_false))
   (True_induction 2 optional #f (not))
   (not_both_true_and_false 1 #f #f (not_both_true_and_false))
   (informal_not_PNP 1 #f #t ())
   (ev_not_ev_S 1 #f #f (ev_not_ev_S classic_double_neg))
   (classical_axioms 5 optional #f (peirce))
   (beq_false_not_eq 2 optional #f (beq_false_not_eq some_nat_is_even))
   (dist_not_exists 1 #f #f (dist_not_exists))
   (not_exists_dist 3 optional #f (not_exists_dist))
   (dist_exists_or 2 #f #f (dist_exists_or))
   (two_defs_of_eq_coincide 3 optional #f (two_defs_of_eq_coincide))
   (filter_challenge 4 optional #t ())
   (filter_challenge_2 5 optional #t ())
   (no_repeats 4 optional #f (appears_in_app app_appears_in))
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
    (test_nostutter_1 test_nostutter_2 test_nostutter_3 test_nostutter_4))
   (|pigeonhole principle|
    4
    optional
    #f
    (app_length appears_in_app_split pigeonhole_principle))
   (and_ind_principle 1 optional #t ())
   (or_ind_principle 1 optional #t ())))
 (Imp
  ((optimize_0plus_b 3 #f #t ())
   (optimizer 4 optional #t ())
   (bevalR 3 #f #t ())
   (beq_id_eq 1 optional #f (beq_id_eq))
   (beq_id_false_not_eq 1 optional #f (beq_id_false_not_eq))
   (not_eq_beq_id_false 1 optional #f (not_eq_beq_id_false))
   (beq_id_sym 1 optional #f (beq_id_sym state))
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
   (no_whiles_terminating
    4
    optional
    #f
    (fact_invariant s_execute1 s_execute2 s_compile s_compile_correct))))
 (ImpCEvalFun
  ((pup_to_n 2 recommended #f (pup_to_n))
   (peven 2 optional #t ())
   (ceval_step__ceval_inf 4 #f #t ())
   (ceval__ceval_step 3 recommended #f (ceval__ceval_step))))
 (Equiv
  ((IFB_false 2 recommended #f (IFB_false))
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
   (optimize_0plus 4 optional #f (subst_equiv_property))
   (inequiv_exercise 3 recommended #f (inequiv_exercise))
   (himp_ceval 2 #f #f (havoc_example1 havoc_example2 cequiv))
   (havoc_copy 4 #f #f (ptwice))
   (havoc_diverge 5 optional #f (p1 p3 p5 stequiv))
   (stequiv_sym 1 optional #f (stequiv_sym))
   (stequiv_trans 1 optional #f (stequiv_trans))
   (stequiv_update 1 optional #f (stequiv_update))
   (stequiv_aeval 2 optional #f (stequiv_aeval))
   (stequiv_beval 2 optional #f (stequiv_beval |cequiv'|))
   (for_while_equiv 4 optional #t ())
   (swap_noninterfering_assignments
    3
    optional
    #f
    (swap_noninterfering_assignments))))
 (Hoare
  ((hoare_asgn_weakest 2 #f #f (hoare_asgn_weakest silly1 silly2))
   (hoare_asgn_examples_2 2 #f #t ())
   (hoare_asgn_example4 2 #f #f (hoare_asgn_example4))
   (swap_exercise 3 #f #t ())
   (hoarestate1 3 optional #f (bassn))
   (hoare_repeat 4 #f #f (hoare_triple))
   (himp_hoare
    3
    #f
    #f
    (hoare_triple hoare_havoc hoare_havoc_weakest subtract_slowly fact_body))
   (slow_assignment_dec
    3
    optional
    #f
    (slow_assignment_dec slow_assignment_dec_correct))
   (factorial_dec 4 optional #t ())))
 (Rel
  ((#f 2 optional #f (|lt_trans''|))
   (#f 1 optional #f (le_S_n))
   (le_Sn_n_inf 2 optional #t ())
   (#f 1 optional #f (le_Sn_n symmetric antisymmetric))
   (#f 2 optional #f (le_step equivalence))
   (rtc_rsc_coincide 3 optional #f (rtc_rsc_coincide))))
 (Smallstep
  ((test_step_2 2 #f #f (test_step_2 deterministic normal_form))
   (value_not_same_as_normal_form
    2
    optional
    #f
    (value_not_same_as_normal_form))
   (|value_not_same_as_normal_form'| 3 #f #f (value_not_same_as_normal_form))
   (smallstep_bools 1 #f #f (bool_step_prop1))
   (step_deterministic 2 optional #f (step_deterministic))
   (smallstep_bool_shortcut 2 #f #f (bool_step_prop4))
   (properties_of_altered_step 3 optional #f (multistep))
   (test_multistep_3 1 optional #f (test_multistep_3))
   (test_multistep_4 2 #f #f (test_multistep_4 step_normal_form normalizing))
   (eval__multistep 3 #f #f (eval__multistep))
   (eval__multistep_inf 3 #f #t ())
   (step__eval 3 #f #f (step__eval))
   (multistep__eval 3 #f #f (multistep__eval))
   (combined_properties 4 #f #f (cmultistep))
   (#f 3 optional #f (par_body_n))))
 (Types
  ((normalize_ex 1 #f #f (normalize_ex))
   (|normalize_ex'| 1 optional #f (|normalize_ex'| value))
   (value_is_nf 3 optional #f (value_is_nf))
   (step_deterministic 3 optional #f (step_deterministic))
   (succ_hastype_nat__hastype_nat 1 #f #f (succ_hastype_nat__hastype_nat))
   (finish_progress_informal 3 recommended #t ())
   (finish_progress 3 #f #f (progress))
   (step_review 1 #f #t ())
   (finish_preservation_informal 3 recommended #t ())
   (finish_preservation 2 #f #f (preservation))
   (preservation_alternate_proof 3 #f #f (|preservation'|))))
 (Stlc
  ((step_example3 2 #f #f (step_example3))
   (typing_example_2_full 2 optional #f (typing_example_2_full))
   (typing_example_3 2 #f #f (typing_example_3))
   (typing_nonexample_3 3 #f #f (typing_nonexample_3))
   (typing_statements 1 optional #t ())
   (more_typing_statements 1 #f #t ())
   (progress_from_term_ind 3 optional #f (|progress'| closed))
   (subject_expansion_stlc 2 recommended #t ())
   (type_soundness 2 optional #f (stuck))
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
