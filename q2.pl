
palindrome(Old0,Res0,Old1,Res1,Old2,Res2) --> [],{Res0 is Old0, Res1 is Old1, Res2 is Old2}.


palindrome(Old0,Res0,Old1,Res1,Old2,Res2) --> [0], {Res0 is Old0 + 1, Res1 is Old1, Res2 is Old2}. /* update 0*/

palindrome(Old0,Res0,Old1,Res1,Old2,Res2)  --> [1], {Res0 is Old0, Res1 is Old1 + 1, Res2 is Old2}. /* update 1, leave count of others as it is*/

palindrome(Old0,Res0,Old1,Res1,Old2,Res2)  --> [2], {Res0 is Old0, Res1 is Old1, Res2 is Old2 + 1}. /* update 2, leave others count*/



palindrome(Old0,Res0,Old1,Res1, Old2, Res2) --> [0], palindrome(Old0,OldRes0,Old1,OldRes1,Old2,OldRes2), [0], {Res0 is OldRes0 + 2, Res1 is OldRes1, Res2 is OldRes2}.

palindrome(Old0,Res0,Old1,Res1, Old2, Res2) --> [1], palindrome(Old0,OldRes0,Old1,OldRes1,Old2,OldRes2), [1], {Res0 is OldRes0, Res1 is OldRes1 + 2, Res2 is OldRes2}.

palindrome(Old0,Res0,Old1,Res1, Old2, Res2) --> [2], palindrome(Old0,OldRes0,Old1,OldRes1,Old2,OldRes2), [2], {Res0 is OldRes0 , Res1 is OldRes1, Res2 is OldRes2 + 2}.


  s -->  palindrome(0,Res0,0,Res1,0,Res2), [3], {Res2 is Res0 * Res1}, ablock(Res0),bblock(Res1),cblock(Res2),!.
                                        %   ^consume 3

ablock(0)  -->  [].
ablock(NewCount)  -->  [0], {Count  is  NewCount  - 1}, ablock(Count).

bblock(0)  -->  [].
bblock(NewCount)  -->  [1], {Count  is  NewCount  - 1}, bblock(Count).

cblock(0)  -->  [].
cblock(NewCount)  -->  [2],{Count  is  NewCount  - 1},cblock(Count).
