create or replace view aggView6902642334997398245 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7610505821576141645 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6902642334997398245 where Message_hasCreator_Person.MessageId=aggView6902642334997398245.v1;
create or replace view aggView6306875247982274694 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7215293034229311525 as select v1, aggJoin7610505821576141645.annot * aggView6306875247982274694.annot as annot from aggJoin7610505821576141645 join aggView6306875247982274694 using(v1);
create or replace view aggView5750002828276722553 as select v1, SUM(annot) as annot from aggJoin7215293034229311525 group by v1;
create or replace view aggJoin8662441423285320351 as select annot from Person_likes_Message as Person_likes_Message, aggView5750002828276722553 where Person_likes_Message.MessageId=aggView5750002828276722553.v1;
select SUM(annot) as v9 from aggJoin8662441423285320351;
