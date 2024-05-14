create or replace view aggView1044873953921075125 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin640609822296014230 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1044873953921075125 where Message_hasCreator_Person.MessageId=aggView1044873953921075125.v1;
create or replace view aggView4925543044819573473 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin4167177573484554122 as select v1, aggJoin640609822296014230.annot * aggView4925543044819573473.annot as annot from aggJoin640609822296014230 join aggView4925543044819573473 using(v1);
create or replace view aggView4279745955907545475 as select v1, SUM(annot) as annot from aggJoin4167177573484554122 group by v1;
create or replace view aggJoin2447832031093111643 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4279745955907545475 where Comment_replyOf_Message.ParentMessageId=aggView4279745955907545475.v1;
select SUM(annot) as v9 from aggJoin2447832031093111643;
