create or replace view aggView5361634814472261867 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5677137723240038842 as select movie_id as v12 from movie_companies as mc, aggView5361634814472261867 where mc.company_id=aggView5361634814472261867.v1;
create or replace view aggView9214776545706602824 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3997313495094884782 as select movie_id as v12 from movie_keyword as mk, aggView9214776545706602824 where mk.keyword_id=aggView9214776545706602824.v18;
create or replace view aggView315894189446707247 as select v12 from aggJoin3997313495094884782 group by v12;
create or replace view aggJoin4843791169663548304 as select id as v12, title as v20 from title as t, aggView315894189446707247 where t.id=aggView315894189446707247.v12;
create or replace view aggView6576370452397948899 as select v12, MIN(v20) as v31 from aggJoin4843791169663548304 group by v12;
create or replace view aggJoin3934864804052949891 as select v31 from aggJoin5677137723240038842 join aggView6576370452397948899 using(v12);
select MIN(v31) as v31 from aggJoin3934864804052949891;
