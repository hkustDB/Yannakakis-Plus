create or replace view aggView636869778791216706 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8743172759594170396 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView636869778791216706 where Message_hasTag_Tag.MessageId=aggView636869778791216706.v1;
create or replace view aggView5615013124214935891 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3610057982853451305 as select v1, aggJoin8743172759594170396.annot * aggView5615013124214935891.annot as annot from aggJoin8743172759594170396 join aggView5615013124214935891 using(v1);
create or replace view aggView3776782874435898326 as select v1, SUM(annot) as annot from aggJoin3610057982853451305 group by v1;
create or replace view aggJoin5727985124120170973 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3776782874435898326 where Comment_replyOf_Message.ParentMessageId=aggView3776782874435898326.v1;
select SUM(annot) as v9 from aggJoin5727985124120170973;
