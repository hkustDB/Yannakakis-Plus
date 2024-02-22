create or replace view aggView2131918262069525283 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin6237539986359661094 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView2131918262069525283 where pkp2.Person2Id=aggView2131918262069525283.v5;
create or replace view aggView1132894764967074695 as select v2, SUM(annot) as annot, v5 from aggJoin6237539986359661094 group by v2,v5;
create or replace view aggJoin6649592545219169510 as select annot from Person_knows_Person as pkp1, aggView1132894764967074695 where pkp1.Person2Id=aggView1132894764967074695.v2 and Person1Id<v5;
select SUM(annot) as v7 from aggJoin6649592545219169510;
