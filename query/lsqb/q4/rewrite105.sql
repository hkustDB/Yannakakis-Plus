create or replace view aggView4208390534906298166 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin1648350113124134000 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4208390534906298166 where Message_hasCreator_Person.MessageId=aggView4208390534906298166.v1;
create or replace view aggView5543985749061622236 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin8146253433109858900 as select v1, aggJoin1648350113124134000.annot * aggView5543985749061622236.annot as annot from aggJoin1648350113124134000 join aggView5543985749061622236 using(v1);
create or replace view aggView8551065507254848963 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8512274855988130255 as select aggJoin8146253433109858900.annot * aggView8551065507254848963.annot as annot from aggJoin8146253433109858900 join aggView8551065507254848963 using(v1);
select SUM(annot) as v9 from aggJoin8512274855988130255;
