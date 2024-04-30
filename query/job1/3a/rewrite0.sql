create or replace view aggView8539166292247331941 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4616583214675389851 as select movie_id as v12 from movie_keyword as mk, aggView8539166292247331941 where mk.keyword_id=aggView8539166292247331941.v1;
create or replace view aggView8741589861732453503 as select v12 from aggJoin4616583214675389851 group by v12;
create or replace view aggJoin3913067039417754552 as select movie_id as v12, info as v7 from movie_info as mi, aggView8741589861732453503 where mi.movie_id=aggView8741589861732453503.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5110663131777933985 as select v12 from aggJoin3913067039417754552 group by v12;
create or replace view aggJoin586474443055076270 as select title as v13, production_year as v16 from title as t, aggView5110663131777933985 where t.id=aggView5110663131777933985.v12 and production_year>2005;
create or replace view aggView3174500626489225865 as select v13 from aggJoin586474443055076270;
select MIN(v13) as v24 from aggView3174500626489225865;
