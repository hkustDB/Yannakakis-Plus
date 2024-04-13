create or replace view aggView2028853663066364265 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin1723642197209847345 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView2028853663066364265 where mk.movie_id=aggView2028853663066364265.v12;
create or replace view aggView1977619208503140800 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7085703999936261608 as select v12 from aggJoin1723642197209847345 join aggView1977619208503140800 using(v1);
create or replace view aggView1664398984132420076 as select v12 from aggJoin7085703999936261608 group by v12;
create or replace view aggJoin6112893963647590081 as select title as v13, production_year as v16 from title as t, aggView1664398984132420076 where t.id=aggView1664398984132420076.v12 and production_year>2005;
create or replace view aggView1985533504565703866 as select v13 from aggJoin6112893963647590081 group by v13;
select min(v13) as v24 from aggView1985533504565703866;
