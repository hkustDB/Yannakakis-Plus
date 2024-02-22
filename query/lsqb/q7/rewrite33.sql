create or replace view aggView1764313239922061920 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin4433932053985955142 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1764313239922061920 where Message_hasCreator_Person.MessageId=aggView1764313239922061920.v1;
create or replace view aggView2560027861771253887 as select v1, SUM(annot) as annot from aggJoin4433932053985955142 group by v1;
create or replace view aggJoin8803129988885403725 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2560027861771253887 where Comment_replyOf_Message.ParentMessageId=aggView2560027861771253887.v1;
create or replace view aggView2218257649802097508 as select v1, SUM(annot) as annot from aggJoin8803129988885403725 group by v1;
create or replace view aggJoin3712768988007945414 as select annot from Person_likes_Message as Person_likes_Message, aggView2218257649802097508 where Person_likes_Message.MessageId=aggView2218257649802097508.v1;
select SUM(annot) as v9 from aggJoin3712768988007945414;
