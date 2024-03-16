create or replace view aggView7670896596538846649 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4131003677881199370 as select id as v12, title as v13 from title as t, aggView7670896596538846649 where t.id=aggView7670896596538846649.v12 and production_year>2005;
create or replace view aggView2630677648404804803 as select v12, MIN(v13) as v24 from aggJoin4131003677881199370 group by v12;
create or replace view aggJoin1145001846916214421 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2630677648404804803 where mk.movie_id=aggView2630677648404804803.v12;
create or replace view aggView5045417964997839745 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5880151236078295762 as select v24 from aggJoin1145001846916214421 join aggView5045417964997839745 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin5880151236078295762;
select sum(v24) from res;