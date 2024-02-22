create or replace view aggView6590990760989478012 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8317874240548732568 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6590990760989478012 where Message_hasCreator_Person.MessageId=aggView6590990760989478012.v1;
create or replace view aggView6119156760582033716 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7768944697917019086 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6119156760582033716 where Comment_replyOf_Message.ParentMessageId=aggView6119156760582033716.v1;
create or replace view aggView3860845996153697294 as select v1, SUM(annot) as annot from aggJoin7768944697917019086 group by v1;
create or replace view aggJoin3008633985265154942 as select aggJoin8317874240548732568.annot * aggView3860845996153697294.annot as annot from aggJoin8317874240548732568 join aggView3860845996153697294 using(v1);
select SUM(annot) as v9 from aggJoin3008633985265154942;
