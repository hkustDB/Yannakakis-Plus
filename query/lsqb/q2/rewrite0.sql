create or replace view aggView7991541688150802719 as select hasCreator_PersonId as v2, PostId as v6, COUNT(*) as annot from Post as Post group by hasCreator_PersonId,PostId;
create or replace view aggJoin5885156359327609340 as select Person1Id as v1, v6, annot from Person_knows_Person as Person_knows_Person, aggView7991541688150802719 where Person_knows_Person.Person2Id=aggView7991541688150802719.v2;
create or replace view aggView7302919687535272384 as select v6, v1, SUM(annot) as annot from aggJoin5885156359327609340 group by v6,v1;
create or replace view aggJoin351542682763163489 as select annot from Comment as Comment, aggView7302919687535272384 where Comment.replyOf_PostId=aggView7302919687535272384.v6 and Comment.hasCreator_PersonId=aggView7302919687535272384.v1;
select SUM(annot) as v12 from aggJoin351542682763163489;
