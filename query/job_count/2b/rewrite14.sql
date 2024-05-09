create or replace view aggView6137398703102194895 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin7007191113335421127 as select movie_id as v12 from movie_companies as mc, aggView6137398703102194895 where mc.company_id=aggView6137398703102194895.v1;
create or replace view aggView1539411261725372168 as select v12, COUNT(*) as annot from aggJoin7007191113335421127 group by v12;
create or replace view aggJoin4289456362704558156 as select id as v12, annot from title as t, aggView1539411261725372168 where t.id=aggView1539411261725372168.v12;
create or replace view aggView2895075945225435556 as select v12, SUM(annot) as annot from aggJoin4289456362704558156 group by v12;
create or replace view aggJoin4040344863034271095 as select keyword_id as v18, annot from movie_keyword as mk, aggView2895075945225435556 where mk.movie_id=aggView2895075945225435556.v12;
create or replace view aggView3774284648469080671 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5561139609311203045 as select annot from aggJoin4040344863034271095 join aggView3774284648469080671 using(v18);
select SUM(annot) as v31 from aggJoin5561139609311203045;
