create or replace view aggView1709520712417331774 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2247809438245386187 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1709520712417331774 where Message_hasCreator_Person.MessageId=aggView1709520712417331774.v1;
create or replace view aggView5657093823363654069 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin3361435999150919675 as select v1, aggJoin2247809438245386187.annot * aggView5657093823363654069.annot as annot from aggJoin2247809438245386187 join aggView5657093823363654069 using(v1);
create or replace view aggView1587106857086193174 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8238291160190600517 as select aggJoin3361435999150919675.annot * aggView1587106857086193174.annot as annot from aggJoin3361435999150919675 join aggView1587106857086193174 using(v1);
select SUM(annot) as v9 from aggJoin8238291160190600517;
