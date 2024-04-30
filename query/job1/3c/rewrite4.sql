create or replace view aggView579900863029621108 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6195377434879629331 as select id as v12, title as v13, production_year as v16 from title as t, aggView579900863029621108 where t.id=aggView579900863029621108.v12 and production_year>1990;
create or replace view aggView5845054520488516831 as select v12, MIN(v13) as v24 from aggJoin6195377434879629331 group by v12;
create or replace view aggJoin5413993555415403533 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5845054520488516831 where mk.movie_id=aggView5845054520488516831.v12;
create or replace view aggView1799368845191025309 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin418841228438210006 as select v24 from aggJoin5413993555415403533 join aggView1799368845191025309 using(v1);
select MIN(v24) as v24 from aggJoin418841228438210006;
