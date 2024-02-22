create or replace view aggView1281938532532634848 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3513863947687895663 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1281938532532634848 where Person_likes_Message.MessageId=aggView1281938532532634848.v1;
create or replace view aggView2644369350664286414 as select v1, SUM(annot) as annot from aggJoin3513863947687895663 group by v1;
create or replace view aggJoin1343323794733153504 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2644369350664286414 where Message_hasTag_Tag.MessageId=aggView2644369350664286414.v1;
create or replace view aggView4300704186857356747 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5832756155408474088 as select aggJoin1343323794733153504.annot * aggView4300704186857356747.annot as annot from aggJoin1343323794733153504 join aggView4300704186857356747 using(v1);
select SUM(annot) as v9 from aggJoin5832756155408474088;
