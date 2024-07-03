create or replace view aggView3917110437972869980 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin301927293304000498 as select movie_id as v12 from movie_companies as mc, aggView3917110437972869980 where mc.company_id=aggView3917110437972869980.v1;
create or replace view aggView5311106538212922935 as select v12 from aggJoin301927293304000498 group by v12;
create or replace view aggJoin8333126402419511900 as select id as v12, title as v20 from title as t, aggView5311106538212922935 where t.id=aggView5311106538212922935.v12;
create or replace view aggView2641390719002184874 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5110390504759798580 as select movie_id as v12 from movie_keyword as mk, aggView2641390719002184874 where mk.keyword_id=aggView2641390719002184874.v18;
create or replace view aggView7883831215427430577 as select v12, MIN(v20) as v31 from aggJoin8333126402419511900 group by v12;
create or replace view aggJoin6954930404085454873 as select v31 from aggJoin5110390504759798580 join aggView7883831215427430577 using(v12);
select MIN(v31) as v31 from aggJoin6954930404085454873;
