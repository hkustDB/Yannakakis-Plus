create or replace view aggView2682910625444806237 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin31514604270843900 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2682910625444806237 where Comment_replyOf_Message.ParentMessageId=aggView2682910625444806237.v1;
create or replace view aggView5303480925069082981 as select v1, SUM(annot) as annot from aggJoin31514604270843900 group by v1;
create or replace view aggJoin8525543621134772101 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5303480925069082981 where Message_hasCreator_Person.MessageId=aggView5303480925069082981.v1;
create or replace view aggView1809673180419180760 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin3782299442890906006 as select aggJoin8525543621134772101.annot * aggView1809673180419180760.annot as annot from aggJoin8525543621134772101 join aggView1809673180419180760 using(v1);
select SUM(annot) as v9 from aggJoin3782299442890906006;
