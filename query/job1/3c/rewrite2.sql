create or replace view aggView6641728740357395631 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4950821428002497909 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6641728740357395631 where mk.movie_id=aggView6641728740357395631.v12;
create or replace view aggView2207729856360249438 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4742549202625885307 as select v12 from aggJoin4950821428002497909 join aggView2207729856360249438 using(v1);
create or replace view aggView1228776640427159471 as select v12 from aggJoin4742549202625885307 group by v12;
create or replace view aggJoin5485577241655760974 as select title as v13, production_year as v16 from title as t, aggView1228776640427159471 where t.id=aggView1228776640427159471.v12 and production_year>1990;
create or replace view aggView3126531594558296847 as select v13 from aggJoin5485577241655760974 group by v13;
select min(v13) as v24 from aggView3126531594558296847;
