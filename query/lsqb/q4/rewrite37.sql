create or replace view aggView6403138963276635609 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5825873969731042596 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6403138963276635609 where Message_hasCreator_Person.MessageId=aggView6403138963276635609.v1;
create or replace view aggView795806424008964819 as select v1, SUM(annot) as annot from aggJoin5825873969731042596 group by v1;
create or replace view aggJoin502922454216404606 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView795806424008964819 where Message_hasTag_Tag.MessageId=aggView795806424008964819.v1;
create or replace view aggView8645739446443697139 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin9201078417545779518 as select aggJoin502922454216404606.annot * aggView8645739446443697139.annot as annot from aggJoin502922454216404606 join aggView8645739446443697139 using(v1);
select SUM(annot) as v9 from aggJoin9201078417545779518;
