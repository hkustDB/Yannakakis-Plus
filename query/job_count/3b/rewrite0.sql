create or replace view aggView6405371132607993268 as select id as v12 from title as t where production_year>2010;
create or replace view aggJoin6525081616754610413 as select movie_id as v12, info as v7 from movie_info as mi, aggView6405371132607993268 where mi.movie_id=aggView6405371132607993268.v12 and info= 'Bulgaria';
create or replace view aggView3900149368835168819 as select v12, COUNT(*) as annot from aggJoin6525081616754610413 group by v12;
create or replace view aggJoin8830156915806151869 as select keyword_id as v1, annot from movie_keyword as mk, aggView3900149368835168819 where mk.movie_id=aggView3900149368835168819.v12;
create or replace view aggView5924125022768649788 as select v1, SUM(annot) as annot from aggJoin8830156915806151869 group by v1;
create or replace view aggJoin5407469556714946378 as select keyword as v2, annot from keyword as k, aggView5924125022768649788 where k.id=aggView5924125022768649788.v1 and keyword LIKE '%sequel%';
select SUM(annot) as v24 from aggJoin5407469556714946378;
