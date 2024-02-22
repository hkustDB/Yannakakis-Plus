create or replace view aggView8333466458371228979 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2955873397018162590 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8333466458371228979 where Person_likes_Message.MessageId=aggView8333466458371228979.v1;
create or replace view aggView6128407659404032399 as select v1, SUM(annot) as annot from aggJoin2955873397018162590 group by v1;
create or replace view aggJoin1232734965524024281 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6128407659404032399 where Message_hasTag_Tag.MessageId=aggView6128407659404032399.v1;
create or replace view aggView6279213965834413766 as select v1, SUM(annot) as annot from aggJoin1232734965524024281 group by v1;
create or replace view aggJoin8708625845562950653 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6279213965834413766 where Message_hasCreator_Person.MessageId=aggView6279213965834413766.v1;
select SUM(annot) as v9 from aggJoin8708625845562950653;
