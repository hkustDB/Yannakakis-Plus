create or replace view aggView5288782110584613299 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin9082435230134711387 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView5288782110584613299 where mk.movie_id=aggView5288782110584613299.v14;
create or replace view aggView6514580039330911628 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6854791007536243332 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6514580039330911628 where mi_idx.info_type_id=aggView6514580039330911628.v1 and info>'5.0';
create or replace view aggView6842461433551132499 as select v14, MIN(v9) as v26 from aggJoin6854791007536243332 group by v14;
create or replace view aggJoin1523378854834322274 as select v3, v27 as v27, v26 from aggJoin9082435230134711387 join aggView6842461433551132499 using(v14);
create or replace view aggView1074788174957257083 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4577093401777798870 as select v27, v26 from aggJoin1523378854834322274 join aggView1074788174957257083 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4577093401777798870;
