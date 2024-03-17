create or replace view aggView8973079516702602911 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin73095347399137774 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView8973079516702602911 where mk.movie_id=aggView8973079516702602911.v12;
create or replace view aggView6274436250710048943 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3094047734643239219 as select v12 from aggJoin73095347399137774 join aggView6274436250710048943 using(v1);
create or replace view aggView7903283951695756844 as select v12 from aggJoin3094047734643239219 group by v12;
create or replace view aggJoin6563135223050672054 as select title as v13 from title as t, aggView7903283951695756844 where t.id=aggView7903283951695756844.v12 and production_year>2005;
select MIN(v13) as v24 from aggJoin6563135223050672054;
