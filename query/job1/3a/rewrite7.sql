create or replace view aggView4874017582662371087 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4150611143076848173 as select movie_id as v12 from movie_keyword as mk, aggView4874017582662371087 where mk.keyword_id=aggView4874017582662371087.v1;
create or replace view aggView5695212679447902049 as select v12 from aggJoin4150611143076848173 group by v12;
create or replace view aggJoin7905573102856610256 as select id as v12, title as v13 from title as t, aggView5695212679447902049 where t.id=aggView5695212679447902049.v12 and production_year>2005;
create or replace view aggView5995915390223379642 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6916728930200019936 as select v13 from aggJoin7905573102856610256 join aggView5995915390223379642 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin6916728930200019936;
select sum(v24) from res;