create or replace view aggView1584305707684892433 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1660180963308764399 as select movie_id as v12 from movie_keyword as mk, aggView1584305707684892433 where mk.keyword_id=aggView1584305707684892433.v1;
create or replace view aggView4216334823731467187 as select v12 from aggJoin1660180963308764399 group by v12;
create or replace view aggJoin7732785281702742064 as select id as v12, title as v13 from title as t, aggView4216334823731467187 where t.id=aggView4216334823731467187.v12 and production_year>2010;
create or replace view aggView8566767281509094436 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4175189320718426842 as select v13 from aggJoin7732785281702742064 join aggView8566767281509094436 using(v12);
select MIN(v13) as v24 from aggJoin4175189320718426842;
