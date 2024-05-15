create or replace view aggView3389348230666454182 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2091045973004358919 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3389348230666454182 where mi_idx.info_type_id=aggView3389348230666454182.v1 and info>'9.0';
create or replace view aggView1940018988853719794 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin6617505539590964794 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView1940018988853719794 where mk.movie_id=aggView1940018988853719794.v14;
create or replace view aggView1153432361876552874 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6252942087601768835 as select v14, v27 from aggJoin6617505539590964794 join aggView1153432361876552874 using(v3);
create or replace view aggView3245036227274827443 as select v14, MIN(v9) as v26 from aggJoin2091045973004358919 group by v14;
create or replace view aggJoin1937282304285329894 as select v27 as v27, v26 from aggJoin6252942087601768835 join aggView3245036227274827443 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1937282304285329894;
