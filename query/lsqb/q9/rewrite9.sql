## AggReduce Phase: 

# AggReduce27
# 1. aggView
create or replace view aggView6912335183616953033 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin6944527501081635500 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView6912335183616953033 where pkp2.Person2Id=aggView6912335183616953033.v4;

# AggReduce28
# 1. aggView
create or replace view aggView2569035021028246456 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin4235865400511240513 as select v4, aggJoin6944527501081635500.annot * aggView2569035021028246456.annot as annot from aggJoin6944527501081635500 join aggView2569035021028246456 using(v2) where v1 < v4;

# AggReduce29
# 1. aggView
create or replace view aggView8023665024631234933 as select v4, SUM(annot) as annot from aggJoin4235865400511240513 group by v4;
# 2. aggJoin
create or replace view aggJoin1358115460914478321 as select annot from Person_knows_Person as pkp3, aggView8023665024631234933 where pkp3.Person1Id=aggView8023665024631234933.v4;
# Final result: 
select SUM(annot) as v9 from aggJoin1358115460914478321;

# drop view aggView6912335183616953033, aggJoin6944527501081635500, aggView2569035021028246456, aggJoin4235865400511240513, aggView8023665024631234933, aggJoin1358115460914478321;
