create or replace view aggView1066138541963949314 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin850462062389549117 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1066138541963949314 where Person_likes_Message.MessageId=aggView1066138541963949314.v1;
create or replace view aggView4585300377465056629 as select v1, SUM(annot) as annot from aggJoin850462062389549117 group by v1;
create or replace view aggJoin1459864168656023689 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4585300377465056629 where Message_hasTag_Tag.MessageId=aggView4585300377465056629.v1;
create or replace view aggView2036735805112001298 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6778259352369567938 as select aggJoin1459864168656023689.annot * aggView2036735805112001298.annot as annot from aggJoin1459864168656023689 join aggView2036735805112001298 using(v1);
select SUM(annot) as v9 from aggJoin6778259352369567938;
