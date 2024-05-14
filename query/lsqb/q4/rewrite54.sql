create or replace view aggView6293996079660413682 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6572177568480519788 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6293996079660413682 where Message_hasCreator_Person.MessageId=aggView6293996079660413682.v1;
create or replace view aggView2728127958913269114 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1473050505517514969 as select v1, aggJoin6572177568480519788.annot * aggView2728127958913269114.annot as annot from aggJoin6572177568480519788 join aggView2728127958913269114 using(v1);
create or replace view aggView5943644879001873230 as select v1, SUM(annot) as annot from aggJoin1473050505517514969 group by v1;
create or replace view aggJoin3277357768901936988 as select annot from Person_likes_Message as Person_likes_Message, aggView5943644879001873230 where Person_likes_Message.MessageId=aggView5943644879001873230.v1;
select SUM(annot) as v9 from aggJoin3277357768901936988;
