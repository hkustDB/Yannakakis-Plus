create or replace view aggView3019540426449403566 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin1615834454430488426 as select movie_id as v12 from movie_companies as mc, aggView3019540426449403566 where mc.company_id=aggView3019540426449403566.v1;
create or replace view aggView8477204687539996490 as select v12 from aggJoin1615834454430488426 group by v12;
create or replace view aggJoin5918045321889763867 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView8477204687539996490 where mk.movie_id=aggView8477204687539996490.v12;
create or replace view aggView1057092696436790874 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5032258967948396958 as select v12 from aggJoin5918045321889763867 join aggView1057092696436790874 using(v18);
create or replace view aggView1725356139543129042 as select v12 from aggJoin5032258967948396958 group by v12;
create or replace view aggJoin1492412274389938207 as select title as v20 from title as t, aggView1725356139543129042 where t.id=aggView1725356139543129042.v12;
select MIN(v20) as v31 from aggJoin1492412274389938207;
