create or replace view aggView4588329247397866142 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5055255913097467921 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4588329247397866142 where Message_hasCreator_Person.MessageId=aggView4588329247397866142.v1;
create or replace view aggView5849908365688078200 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin5136797325511096893 as select v1, aggJoin5055255913097467921.annot * aggView5849908365688078200.annot as annot from aggJoin5055255913097467921 join aggView5849908365688078200 using(v1);
create or replace view aggView5599204871496283934 as select v1, SUM(annot) as annot from aggJoin5136797325511096893 group by v1;
create or replace view aggJoin2798133200107885914 as select annot from Person_likes_Message as Person_likes_Message, aggView5599204871496283934 where Person_likes_Message.MessageId=aggView5599204871496283934.v1;
select SUM(annot) as v9 from aggJoin2798133200107885914;
