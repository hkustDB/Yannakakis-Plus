create or replace view aggView5815609668596214759 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin665042364041964675 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5815609668596214759 where Person_likes_Message.MessageId=aggView5815609668596214759.v1;
create or replace view aggView1614967019074686033 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin7385156231663066376 as select v1, aggJoin665042364041964675.annot * aggView1614967019074686033.annot as annot from aggJoin665042364041964675 join aggView1614967019074686033 using(v1);
create or replace view aggView3422478157775645568 as select v1, SUM(annot) as annot from aggJoin7385156231663066376 group by v1;
create or replace view aggJoin45921002199514100 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3422478157775645568 where Message_hasTag_Tag.MessageId=aggView3422478157775645568.v1;
select SUM(annot) as v9 from aggJoin45921002199514100;
