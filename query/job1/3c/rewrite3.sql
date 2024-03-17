create or replace view aggView8701731055285372589 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin3294063229183959679 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8701731055285372589 where mi.movie_id=aggView8701731055285372589.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6958317826613359215 as select v12, MIN(v24) as v24 from aggJoin3294063229183959679 group by v12;
create or replace view aggJoin3422292792241799104 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6958317826613359215 where mk.movie_id=aggView6958317826613359215.v12;
create or replace view aggView2321794461864124194 as select v1, MIN(v24) as v24 from aggJoin3422292792241799104 group by v1;
create or replace view aggJoin1886775757425055391 as select keyword as v2, v24 from keyword as k, aggView2321794461864124194 where k.id=aggView2321794461864124194.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin1886775757425055391;
select sum(v24) from res;