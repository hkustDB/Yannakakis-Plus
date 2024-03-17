create or replace view aggView4886558639114612649 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5896964947039294283 as select movie_id as v14 from movie_keyword as mk, aggView4886558639114612649 where mk.keyword_id=aggView4886558639114612649.v3;
create or replace view aggView4538796332191355659 as select v14 from aggJoin5896964947039294283 group by v14;
create or replace view aggJoin6085703739328134960 as select id as v14, title as v15 from title as t, aggView4538796332191355659 where t.id=aggView4538796332191355659.v14 and production_year>2010;
create or replace view aggView5707670654723767692 as select v14, MIN(v15) as v27 from aggJoin6085703739328134960 group by v14;
create or replace view aggJoin1546852935241732711 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5707670654723767692 where mi_idx.movie_id=aggView5707670654723767692.v14 and info>'9.0';
create or replace view aggView4458983984456566328 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1546852935241732711 group by v1;
create or replace view aggJoin8114867280913199085 as select v27, v26 from info_type as it, aggView4458983984456566328 where it.id=aggView4458983984456566328.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8114867280913199085;
