create or replace view aggView886489557087201804 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin835429578046409875 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView886489557087201804 where Comment_replyOf_Message.ParentMessageId=aggView886489557087201804.v1;
create or replace view aggView8778006627688046646 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2653008951144170471 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8778006627688046646 where Message_hasCreator_Person.MessageId=aggView8778006627688046646.v1;
create or replace view aggView8935203857567671698 as select v1, SUM(annot) as annot from aggJoin2653008951144170471 group by v1;
create or replace view aggJoin371917805405548383 as select aggJoin835429578046409875.annot * aggView8935203857567671698.annot as annot from aggJoin835429578046409875 join aggView8935203857567671698 using(v1);
select SUM(annot) as v9 from aggJoin371917805405548383;
