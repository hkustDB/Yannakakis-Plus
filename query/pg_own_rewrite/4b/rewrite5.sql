create or replace view aggView1435065199583578334 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6241362817446242320 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1435065199583578334 where mi_idx.info_type_id=aggView1435065199583578334.v1 and info>'9.0';
create or replace view aggView7568693591623994775 as select v14, MIN(v9) as v26 from aggJoin6241362817446242320 group by v14;
create or replace view aggJoin3568363562215541410 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView7568693591623994775 where t.id=aggView7568693591623994775.v14 and production_year>2010;
create or replace view aggView4593942049962687535 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7106357721201924444 as select movie_id as v14 from movie_keyword as mk, aggView4593942049962687535 where mk.keyword_id=aggView4593942049962687535.v3;
create or replace view aggView5869568522026859079 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin3568363562215541410 group by v14,v26;
create or replace view aggJoin1500934048429587771 as select v26, v27 from aggJoin7106357721201924444 join aggView5869568522026859079 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1500934048429587771;
