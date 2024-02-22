create or replace view aggView5304768767277989737 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin6667584356377799171 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5304768767277989737 where Message_hasCreator_Person.MessageId=aggView5304768767277989737.v1;
create or replace view aggView750009578775982159 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin372041453199829697 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView750009578775982159 where Message_hasTag_Tag.MessageId=aggView750009578775982159.v1;
create or replace view aggView4010740249728982511 as select v1, SUM(annot) as annot from aggJoin372041453199829697 group by v1;
create or replace view aggJoin6049310321634367410 as select aggJoin6667584356377799171.annot * aggView4010740249728982511.annot as annot from aggJoin6667584356377799171 join aggView4010740249728982511 using(v1);
select SUM(annot) as v9 from aggJoin6049310321634367410;
