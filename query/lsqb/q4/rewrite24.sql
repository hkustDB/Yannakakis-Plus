create or replace view aggView2992611069174441553 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8786536327978655568 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2992611069174441553 where Comment_replyOf_Message.ParentMessageId=aggView2992611069174441553.v1;
create or replace view aggView4686262138665792976 as select v1, SUM(annot) as annot from aggJoin8786536327978655568 group by v1;
create or replace view aggJoin5891955109695424831 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4686262138665792976 where Message_hasTag_Tag.MessageId=aggView4686262138665792976.v1;
create or replace view aggView82538784155282231 as select v1, SUM(annot) as annot from aggJoin5891955109695424831 group by v1;
create or replace view aggJoin8635456088617708858 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView82538784155282231 where Message_hasCreator_Person.MessageId=aggView82538784155282231.v1;
select SUM(annot) as v9 from aggJoin8635456088617708858;
