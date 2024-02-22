create or replace view aggView5768178740034784409 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin277216195485416723 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5768178740034784409 where Message_hasCreator_Person.MessageId=aggView5768178740034784409.v1;
create or replace view aggView3921893380097873072 as select v1, SUM(annot) as annot from aggJoin277216195485416723 group by v1;
create or replace view aggJoin6414925020519597175 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3921893380097873072 where Person_likes_Message.MessageId=aggView3921893380097873072.v1;
create or replace view aggView5988634119607860510 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7672732108107418599 as select aggJoin6414925020519597175.annot * aggView5988634119607860510.annot as annot from aggJoin6414925020519597175 join aggView5988634119607860510 using(v1);
select SUM(annot) as v9 from aggJoin7672732108107418599;
