create or replace view aggView7494571017685588252 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6065980065661648285 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7494571017685588252 where mi_idx.info_type_id=aggView7494571017685588252.v1 and info>'5.0';
create or replace view aggView8008415540505142924 as select v14, MIN(v9) as v26 from aggJoin6065980065661648285 group by v14;
create or replace view aggJoin5377488960127373420 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView8008415540505142924 where t.id=aggView8008415540505142924.v14 and production_year>2005;
create or replace view aggView6940254352715149357 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5377488960127373420 group by v14,v26;
create or replace view aggJoin9058147766852423861 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView6940254352715149357 where mk.movie_id=aggView6940254352715149357.v14;
create or replace view aggView4694165727331483145 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4647697497447507992 as select v26, v27 from aggJoin9058147766852423861 join aggView4694165727331483145 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4647697497447507992;
