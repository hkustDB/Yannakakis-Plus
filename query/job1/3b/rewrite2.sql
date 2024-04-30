create or replace view aggView4090603017367796208 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2676065682644568686 as select movie_id as v12 from movie_keyword as mk, aggView4090603017367796208 where mk.keyword_id=aggView4090603017367796208.v1;
create or replace view aggView453107719872793925 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin1075067025040979395 as select v12 from aggJoin2676065682644568686 join aggView453107719872793925 using(v12);
create or replace view aggView8960927718307465645 as select v12 from aggJoin1075067025040979395 group by v12;
create or replace view aggJoin3630245160028101773 as select title as v13, production_year as v16 from title as t, aggView8960927718307465645 where t.id=aggView8960927718307465645.v12 and production_year>2010;
create or replace view aggView1715143687086829091 as select v13 from aggJoin3630245160028101773;
select MIN(v13) as v24 from aggView1715143687086829091;
