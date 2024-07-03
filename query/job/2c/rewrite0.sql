create or replace view aggView2644272637909241630 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8325125223681212184 as select movie_id as v12 from movie_keyword as mk, aggView2644272637909241630 where mk.keyword_id=aggView2644272637909241630.v18;
create or replace view aggView1284735309389430798 as select v12 from aggJoin8325125223681212184 group by v12;
create or replace view aggJoin6052012657299486261 as select id as v12, title as v20 from title as t, aggView1284735309389430798 where t.id=aggView1284735309389430798.v12;
create or replace view aggView2427379882568260010 as select v12, MIN(v20) as v31 from aggJoin6052012657299486261 group by v12;
create or replace view aggJoin7221079723903061903 as select company_id as v1, v31 from movie_companies as mc, aggView2427379882568260010 where mc.movie_id=aggView2427379882568260010.v12;
create or replace view aggView7785093977424832868 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin7908299200155319811 as select v31 from aggJoin7221079723903061903 join aggView7785093977424832868 using(v1);
select MIN(v31) as v31 from aggJoin7908299200155319811;
