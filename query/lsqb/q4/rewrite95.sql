create or replace view aggView8904335003540049020 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7430277792110218284 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8904335003540049020 where Message_hasCreator_Person.MessageId=aggView8904335003540049020.v1;
create or replace view aggView7466257458676736508 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin8798300586765656378 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7466257458676736508 where Message_hasTag_Tag.MessageId=aggView7466257458676736508.v1;
create or replace view aggView6355603504282660127 as select v1, SUM(annot) as annot from aggJoin8798300586765656378 group by v1;
create or replace view aggJoin2626065727782519512 as select aggJoin7430277792110218284.annot * aggView6355603504282660127.annot as annot from aggJoin7430277792110218284 join aggView6355603504282660127 using(v1);
select SUM(annot) as v9 from aggJoin2626065727782519512;
