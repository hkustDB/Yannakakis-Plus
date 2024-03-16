create or replace view aggView8956615868261898850 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin699590686346548161 as select movie_id as v12 from movie_companies as mc, aggView8956615868261898850 where mc.company_id=aggView8956615868261898850.v1;
create or replace view aggView6376127004482256139 as select v12 from aggJoin699590686346548161 group by v12;
create or replace view aggJoin8667907858409180753 as select id as v12, title as v20 from title as t, aggView6376127004482256139 where t.id=aggView6376127004482256139.v12;
create or replace view aggView2842217234042572895 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5177418921527098177 as select movie_id as v12 from movie_keyword as mk, aggView2842217234042572895 where mk.keyword_id=aggView2842217234042572895.v18;
create or replace view aggView1003713579638731755 as select v12 from aggJoin5177418921527098177 group by v12;
create or replace view aggJoin4009874996413815674 as select v20 from aggJoin8667907858409180753 join aggView1003713579638731755 using(v12);
select MIN(v20) as v31 from aggJoin4009874996413815674;
