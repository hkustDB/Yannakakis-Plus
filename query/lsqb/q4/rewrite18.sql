create or replace view aggView8418724066959470004 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin4585571328156799540 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8418724066959470004 where Person_likes_Message.MessageId=aggView8418724066959470004.v1;
create or replace view aggView2529875577622006716 as select v1, SUM(annot) as annot from aggJoin4585571328156799540 group by v1;
create or replace view aggJoin9061713704299494489 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2529875577622006716 where Message_hasCreator_Person.MessageId=aggView2529875577622006716.v1;
create or replace view aggView7028892846952667747 as select v1, SUM(annot) as annot from aggJoin9061713704299494489 group by v1;
create or replace view aggJoin4874806144799009324 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7028892846952667747 where Comment_replyOf_Message.ParentMessageId=aggView7028892846952667747.v1;
select SUM(annot) as v9 from aggJoin4874806144799009324;
