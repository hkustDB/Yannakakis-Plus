create or replace view aggView58588953394513173 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5826678536995925351 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView58588953394513173 where mi_idx.info_type_id=aggView58588953394513173.v1 and info>'9.0';
create or replace view aggView4500028099048434969 as select v14, MIN(v9) as v26 from aggJoin5826678536995925351 group by v14;
create or replace view aggJoin9000637853038354085 as select movie_id as v14, keyword_id as v3, v26 from movie_keyword as mk, aggView4500028099048434969 where mk.movie_id=aggView4500028099048434969.v14;
create or replace view aggView8115546671275833953 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5546358406405555692 as select v14, v26 from aggJoin9000637853038354085 join aggView8115546671275833953 using(v3);
create or replace view aggView1098922006040789536 as select v14, MIN(v26) as v26 from aggJoin5546358406405555692 group by v14;
create or replace view aggJoin7930861901630804732 as select title as v15, v26 from title as t, aggView1098922006040789536 where t.id=aggView1098922006040789536.v14 and production_year>2010;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin7930861901630804732;
