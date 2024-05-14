create or replace view aggView2033024490519408587 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8813942519026683071 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2033024490519408587 where Message_hasCreator_Person.MessageId=aggView2033024490519408587.v1;
create or replace view aggView3929252624293593917 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6680211067003335569 as select v1, aggJoin8813942519026683071.annot * aggView3929252624293593917.annot as annot from aggJoin8813942519026683071 join aggView3929252624293593917 using(v1);
create or replace view aggView4073824229491252412 as select v1, SUM(annot) as annot from aggJoin6680211067003335569 group by v1;
create or replace view aggJoin721689197390169924 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4073824229491252412 where Message_hasTag_Tag.MessageId=aggView4073824229491252412.v1;
select SUM(annot) as v9 from aggJoin721689197390169924;
