create or replace view aggView8128758398319893683 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin755867262414712428 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8128758398319893683 where Message_hasCreator_Person.MessageId=aggView8128758398319893683.v1;
create or replace view aggView7492579111617166655 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2412598595660718259 as select v1, aggJoin755867262414712428.annot * aggView7492579111617166655.annot as annot from aggJoin755867262414712428 join aggView7492579111617166655 using(v1);
create or replace view aggView3051912244665101653 as select v1, SUM(annot) as annot from aggJoin2412598595660718259 group by v1;
create or replace view aggJoin8767053764194098441 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3051912244665101653 where Message_hasTag_Tag.MessageId=aggView3051912244665101653.v1;
select SUM(annot) as v9 from aggJoin8767053764194098441;
