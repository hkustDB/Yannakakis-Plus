create or replace view aggView3437734370298529981 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7549666838637793885 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3437734370298529981 where Message_hasTag_Tag.MessageId=aggView3437734370298529981.v1;
create or replace view aggView6636385191305784116 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin7596585120527650740 as select v1, aggJoin7549666838637793885.annot * aggView6636385191305784116.annot as annot from aggJoin7549666838637793885 join aggView6636385191305784116 using(v1);
create or replace view aggView3162059723460549643 as select v1, SUM(annot) as annot from aggJoin7596585120527650740 group by v1;
create or replace view aggJoin5202687955572093957 as select annot from Person_likes_Message as Person_likes_Message, aggView3162059723460549643 where Person_likes_Message.MessageId=aggView3162059723460549643.v1;
select SUM(annot) as v9 from aggJoin5202687955572093957;
